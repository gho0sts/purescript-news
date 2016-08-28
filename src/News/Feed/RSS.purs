module News.Feed.RSS
( rss
) where

import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Exception (error)
import Control.Monad.Error.Class (throwError)
import Data.List as List
import News.Feed (Entry)
import News.Prelude
import Node.HTTP (HTTP)
import Node.HTTP.Aff (request)

rss :: forall eff. String -> Aff (http :: HTTP | eff) (List Entry)
rss url = do
  text <- request url
  case parse Just Nothing text of
    Just entries -> pure (List.fromFoldable entries)
    Nothing -> throwError (error "bad RSS feed")

foreign import parse
  :: (forall a. a -> Maybe a)
  -> (forall a. Maybe a)
  -> String
  -> Maybe (Array Entry)