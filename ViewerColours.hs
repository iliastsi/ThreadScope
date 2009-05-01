-------------------------------------------------------------------------------
--- $Id: ViewerColours.hs#1 2009/03/20 13:27:50 REDMOND\\satnams $
--- $Source: //depot/satnams/haskell/ThreadScope/ViewerColours.hs $
-------------------------------------------------------------------------------

module ViewerColours where

import Graphics.UI.Gtk
import Graphics.Rendering.Cairo 

-------------------------------------------------------------------------------

-- Colours

black :: Color
black = Color 0 0 0

green :: Color
green = Color 0 0xFFFF 0

runningColour :: Color
runningColour = green

darkGreen :: Color
darkGreen = Color 0x0000 0x6600 0x0000

blue :: Color
blue = Color 0 0 0xFFFF

cyan :: Color
cyan = Color 0 0xFFFF 0xFFFF 

magenta :: Color
magenta = Color 0xFFFF 0 0xFFFF

lightBlue :: Color
lightBlue = Color 0x6600 0x9900 0xFF00

darkBlue :: Color
darkBlue = Color 0 0 0xBB00

purple :: Color
purple = Color 0x9900 0x0000 0xcc00

darkRed :: Color
darkRed = Color 0xcc00 0x0000 0x0000

orange :: Color
orange = Color 0xFFFF 0x9900 0x0000 -- orange

gcColour :: Color
gcColour = orange

profileBackground :: Color
profileBackground = Color 0xFFFF 0xFFFF 0xFFFF

tickColour :: Color
tickColour = Color 0x3333 0x3333 0xFFFF


-------------------------------------------------------------------------------      
setSourceRGBAhex (Color r g b) t
  = setSourceRGBA (fromIntegral r/0xFFFF) (fromIntegral g/0xFFFF)
                  (fromIntegral b/0xFFFF) t

-------------------------------------------------------------------------------