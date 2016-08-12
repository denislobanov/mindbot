{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}

module Main where

import BasePrelude hiding (readFile)
import Network.Linklater
import Data.Text (Text)
import qualified Data.Text as Text
-- import GHC.Generics
import Data.Text.IO (readFile)
import Network.Wai.Handler.Warp (run)



main :: IO ()
main = do
  url <- Text.filter (/= '\n') <$> readFile "token"
  putStrLn ("Listening on port " <> show port)
  run port (slashSimple (mindbot $ Config url))
  where
    port = 3334

mindbot :: Config -> Maybe Command -> IO Text
mindbot config (Just command@(Command _ user channel _)) = do
  putStrLn (show command)
  return "Hello! :)"

mindbot _ Nothing =
  return "No command given!"
