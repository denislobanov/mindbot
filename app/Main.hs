{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}

module Main where

import BasePrelude hiding (readFile)
import Network.Linklater
import Data.Text (Text)
import qualified Data.Text as Text
-- import GHC.Generics
import Data.Text.IO (readFile)
import Network.Wai.Handler.Warp (run)
import System.Environment
import Control.Monad

main :: IO ()
main = do
  url <-  liftM Text.pack $ getEnv "MINDBOT_TOKEN"
  putStrLn ("Listening on port " <> show port)
  run port (slashSimple mindbot )
  where
    port = 3334

mindbot :: Maybe Command -> IO Text
mindbot (Just command@(Command _ user channel _)) = do
  putStrLn (show command)
  return "Hello! :)"

mindbot Nothing =
  return "No command given!"