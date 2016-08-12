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
  putStrLn $ " Got command: " <> show command
  say message config
  return ""
  where
    message = greeting user channel

mindbot config Nothing = do
  say message config
  return "No command given!"
  where
    message = SimpleMessage (EmojiIcon "wheelie") "mindbot" (GroupChannel "mindbot-testing") "Y I NO WORK?"

greeting :: User -> Channel -> Message
greeting user channel =
  SimpleMessage (EmojiIcon "wheelie") "mindbot" channel $ "Hello " <> username
  where
    username = Text.pack $ show user
