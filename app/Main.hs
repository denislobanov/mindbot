{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}

module Main where

import Web.Slack
import Web.Slack.Message

import BasePrelude
import Control.Monad
import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import Data.Text (Text)
import qualified Data.Text as Text

wrapToken :: String -> SlackConfig
wrapToken token = SlackConfig { _slackApiToken = token }

mindbot :: SlackBot()
--mindbot (ImOpen uid imid) = do
--    sendMessage imid $ "hello " <> show uid
--    return()
mindbot (Message cid usr msg _ _ _) = do
    sendMessage cid $ "hello " <> (Text.pack (show usr))
    return ()

main :: IO ()
main = do
  token <- fromMaybe (error "No $MINDBOT_TOKEN found in environment")
            <$> lookupEnv "MINDBOT_TOKEN"
  putStrLn "Mindbot running."
  runBot (wrapToken token) mindbot ()
