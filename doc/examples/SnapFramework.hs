-- | Example with BlazeHtml running behind the Snap Haskell web framework.
-- For more information on snap, you can refer to http://snapframework.com.
--
{-# LANGUAGE OverloadedStrings #-}
module Main where

import System
import Snap.Http.Server
import Snap.Types

import Text.Blaze.Html5
import qualified Text.Blaze.Html5 as H

-- | A welcome page.
--
welcomePage :: Html a
welcomePage = html $ do
    H.head $ do
        title $ "Snap & BlazeHtml"
    body $ do
        h1 $ "Snap & BlazeHtml"
        p $ "This is an example of BlazeHtml running begind the snap framework."

-- | Auxiliary function to render a BlazeHtlm template to a `Snap ()` type.
--
blazeTemplate :: Html a -> Snap ()
blazeTemplate = writeLBS . renderHtml

-- | Always return the welcome page.
--
site :: Snap ()
site = blazeTemplate welcomePage

-- | Snap main function.
--
main :: IO ()
main = do
    args <- getArgs
    let port = case args of
                   []  -> 8000
                   p:_ -> read p
    httpServe "*" port "myserver"
        (Just "access.log")
        (Just "error.log")
        site