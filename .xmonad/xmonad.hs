import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowArranger
import XMonad.Layout.Mosaic
import XMonad.Layout.Spacing

import System.IO
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Monoid

main = do
    xmproc <- spawnPipe "xmobar"
    spawn "feh --bg-fill --randomize Elements/Mina\\ bilder/Autumn_wg/1920x1050/*"
    xmonad $ defaultConfig
      { terminal    = myTerm
      , modMask     = mod4Mask
      , keys        = myKeys
      , borderWidth = 0
      , manageHook  = manageDocks <+> (isFullscreen --> doFloat) <+> manageHook defaultConfig
      , layoutHook  = myLayout
      , startupHook = setWMName "LG3D"
      , logHook     = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
      } `additionalKeys`
        [ ((mod4Mask .|. shiftMask  , xK_z)       , spawn "xscreensaver-command -lock")
        , ((controlMask             , xK_Print)   , spawn "sleep 0.2; scrot -s")
        , ((0                       , xK_Print)   , spawn "scrot")
        , ((mod4Mask                , xK_Return)  , spawn myTerm )
        ]

myTerm = "xfce4-terminal --hide-menubar"

myLayout = spacing 20 . avoidStruts $ toggleLayouts (noBorders Full)
    (smartBorders (tiled ||| mosaic 2 [3,2] ||| Mirror tiled ||| layoutHints (tabbed shrinkText myTab)))
    where
        tiled   = layoutHints $ ResizableTall nmaster delta ratio []
        nmaster = 1
        delta   = 2/100
        ratio   = 1/2

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_p ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm, xK_semicolon ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p ), spawn "gmrun")
    -- close focused window
    , ((modm .|. shiftMask, xK_c ), kill)
    , ((modm, xK_w ), kill)
    -- Rotate through the available layout algorithms
    , ((modm, xK_space ), sendMessage NextLayout)
    -- Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm, xK_k ), refresh)
    -- Move focus to the next window
    , ((modm, xK_Tab ), windows W.focusDown)
    -- Move focus to the next window
    , ((modm, xK_n ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm, xK_e ), windows W.focusUp )
    -- Move focus to the master window
    , ((modm, xK_m ), windows W.focusMaster )
    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_n ), windows W.swapDown )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_e ), windows W.swapUp )
    -- Shrink the master area
    , ((modm, xK_h ), sendMessage Shrink)
    -- Expand the master area
    , ((modm, xK_i ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm, xK_t ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm , xK_period), sendMessage (IncMasterN (-1)))
    -- Change background
    , ((modm , xK_f), spawn "feh --bg-fill --randomize Elements/Mina\\ bilder/Autumn_wg/1920x1050/*")
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    -- 
    -- , ((modm , xK_b ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q ), io exitSuccess)
    -- Restart xmonad
    , ((modm , xK_q ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    -- 
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- 
    [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myTab = defaultTheme
    { activeColor         = "black"
    , inactiveColor       = "black"
    , urgentColor         = "yellow"
    , activeBorderColor   = "orange"
    , inactiveBorderColor = "#222222"
    , urgentBorderColor   = "black"
    , activeTextColor     = "orange"
    , inactiveTextColor   = "#222222"
    , urgentTextColor     = "yellow" }
