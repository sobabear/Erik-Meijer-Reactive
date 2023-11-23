
newtype Iterable a = Iterable
    { 
    getIterator :: () -> IO (Iterator a)
    }
    
data Iterator a = Iterator
{ 
  moveNext :: () -> IO Bool 
  ,current ::() -> a
}

type Iterable a = () -> IO (Iterator a)type Iterator a = () -> IO (Either SomeException (Maybe a))

typeIterablea=()->IO(()->IOa)
typeIteratora=()->IOa



                                   A <: B
                      ----------------------------------
                          () -> IO A <: () -> IO B


     Coke <: Drink
                      ---------------------------------
                       VendingM Coke <: VendingM Drink


newtype Iterator a = Iterator  { moveNext :: () -> IO a }

instance Functor Iterator where
    fmap f ia  = Iterator $ \() -> liftM f (moveNext ia ())

newtype Iterable a = Iterable
{ 
getIterator :: () -> IO (Iterator a)
}


instance Functor Iterable where
    fmap f iia = Iterable $ \() -> liftM (fmap f) (getIterator iia ())




{-
    () -> (() -> a) -- iterable
    () <- (() <- a) -- apply duality
    (a -> ()) -> () -- observable
-}
type Iterator a = () -> IO a 
-- = () IO <- a
type Observer a = a -> IO ()
typeIterable a = () -> IO (() -> IO a) 
-- = () IO <- (() IO <- a) 
type Observable a = (a -> IO ()) -> IO ()




      Coke <: Drink
                    -----------------------------------
                    RecyclingM Drink <: RecyclingM Coke


         A <: B
                      ----------------------------------
                          A -> IO () <: B -> IO ()


f   ::  a ->  b
     = -a -> +b
g::(a->b)->c = -(-a -> +b) -> +c = (+a->-b)->+c
observer
:: a->() = -a -> ()
observable
:: (a->())->() = -(-a -> ()) -> () = (+a->())->()



newtype Observer a = Observer  { onNext :: a -> IO () }

instance Contravariant Observer where
    contramap f ob = Observer $ onNext ob . f
newtype Observable a = Observable
    { subscribe :: Observer a -> IO ()
    }

instance Functor Observable where
    fmap f ooa = Observable $ subscribe ooa . contramap f



cont :: (a -> r ) -> r
observable :: (a -> IO ()) -> IO ()


newtype Observable a = Observable
    { 
    subscribe :: Observer a -> IO ()
}



data Observer a = Observer
    { onNext       :: a -> IO ()
    , onError      :: SomeException -> IO ()
    , onCompleted  :: IO ()
}
