-------------------------------------------------------------------------------
--- $Id: EventDuration.hs#3 2009/03/25 16:27:24 REDMOND\\satnams $
--- $Source: //depot/satnams/haskell/ThreadScope/EventDuration.hs $
-------------------------------------------------------------------------------

-- This module supports a duration-based data-type to represent thread
-- execution and GC information.

module EventDuration
where

import Data.Array

-- Imports for GHC Events
import qualified GHC.RTS.Events as GHCEvents
import GHC.RTS.Events hiding (Event)

import EventlogViewerCommon
import StartTimes

-------------------------------------------------------------------------------

data EventDuration
  = ThreadRun ThreadId Int Timestamp Timestamp
  | GC Int Timestamp Timestamp
    deriving (Eq, Show)

-------------------------------------------------------------------------------

eventArrayToDuration :: EventArray -> [EventDuration]
eventArrayToDuration = eventArrayToDuration' 0

-------------------------------------------------------------------------------

eventArrayToDuration' :: Int -> EventArray -> [EventDuration]
eventArrayToDuration' idx eventArray 
  = if idx > lastIdx then
      []
    else
      case spec event of
        StopThread{cap=c, thread=t, GHC.RTS.Events.status=s}
           -> runBar t c : rest
        EndGC  {cap=c}  
           -> GC c (gcStartTime c) (time event) : rest
        _ -> rest
    where
    event = eventArray!idx
    rest = eventArrayToDuration' (idx+1) eventArray
    (_, lastIdx) = bounds eventArray
    startTime = findRunThreadTime eventArray (idx-1)
    runBar t c = ThreadRun t c startTime (time event)
    gcStartTime c = findStartGCTime eventArray c (idx-1)

-------------------------------------------------------------------------------