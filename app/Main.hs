{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}

module Main where

import BasePrelude hiding (readFile)
import Network.Linklater
import Data.Text (Text)
import qualified Data.Text as Text
-- import GHC.Generics
import Data.Text.IO (readFile)
import Network.Wai.Handler.Warp (run, Port)
import System.Environment
import Control.Monad

main :: IO ()
main = do
  url <-  liftM Text.pack $ getEnv "MINDBOT_TOKEN"
  port <- liftM (\x -> read x::Port) $ getEnv "PORT"
  putStrLn ("Listening on port " <> show port)
  run port $ slashSimple (mindbot (Config url))

mindbot :: Config -> Maybe Command -> IO Text
mindbot config (Just command@(Command _ user channel _)) = do
  putStrLn (show command)
  say (greeting user channel) config
  return ""

mindbot _ Nothing =
  return "No command given!"

greeting :: User -> Channel -> Message
greeting user channel =
  SimpleMessage (EmojiIcon "wheelie") "mindbot" channel $ "Hello " <> username
  where
    username = Text.pack $ show user
