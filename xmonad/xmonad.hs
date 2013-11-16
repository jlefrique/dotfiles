--
-- xmonad configuration
--
-- My xmonad configuration with some custom key bindings to make the life
-- easier in Dvorak with a TypeMatrix keyboard.
--
-- Julien Lefrique (julien.lefrique@gmail.com)
--

import XMonad
import System.IO
import System.Exit
import Control.Monad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Actions.WindowBringer
import XMonad.Actions.GridSelect
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Dmenu
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Util.WorkspaceCompare

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Default terminal emulator
myTerminal = "urxvt"

-- Use Super instead of Alt for the modifier key
myModKey = mod4Mask

-- -- The default number of workspaces (virtual screens) and their names.
-- -- By default we use numeric strings, but any string may be used as a
-- -- workspace name. The number of workspaces is determined by the length
-- -- of this list.
-- --
-- -- A tagging example:
-- --
-- -- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
-- --
myWorkspaces =
    ["1:term", "2:web", "3:mail", "4:dev", "5:log", "6", "7", "8", "9:vm", "0"]

------------------------------------------------------------------------
-- Custom key bindings
--
myKeys =
    --
    -- New key bindings
    --
    -- Go to the window
    [ ((myModKey .|. shiftMask, xK_g), gotoMenuArgs' "dmenu" ["-p", "goto"])
    -- Bring the window
    , ((myModKey .|. shiftMask, xK_b), bringMenuArgs' "dmenu" ["-p", "bring"])
    -- Display opened windows in a grid
    , ((myModKey, xK_g), goToSelected defaultGSConfig)
    -- Lock the screen
    , ((myModKey .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    -- Launch dmenu-based session manager
    , ((myModKey .|. shiftMask, xK_s), spawn "dmenu_session")
    -- Launch dmenu-based finder
    , ((myModKey, xK_f), spawn "dmenu_find")
    -- Show/hide scratchpad terminal
    , ((myModKey, xK_s), namedScratchpadAction myScratchpads "terminal")
    -- Close focused window with one hand in Dvorak
    , ((myModKey .|. shiftMask, xK_o), kill)
    -- Print screen
    , ((0, xK_Print), spawn "scrot")
    -- XF86AudioMute
    , ((0, 0x1008ff12), spawn "amixer -c 0 set Master toggle")
    -- XF86AudioLowerVolume
    , ((0, 0x1008ff11), spawn "amixer -c 0 set Master 2dB-")
    -- XF86AudioRaiseVolume
    , ((0, 0x1008ff13), spawn "amixer -c 0 set Master 2dB+")
    --
    -- TypeMatrix special keys
    --
    -- Web browser
    , ((0, 0x1008ff18), spawn "firefox")
    -- Email
    , ((0, 0x1008ff19), spawn "thunderbird")
    -- Calculator
    , ((0, 0x1008ff1d), namedScratchpadAction myScratchpads "ipython")
    --
    -- Override default behavior
    --
    -- Quit xmonad
    , ((myModKey .|. shiftMask, xK_q), confirm "Exit?" $ io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((myModKey, xK_q), confirm "Restart?" $ spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    -- Add workspace 0
    [((m .|. myModKey, k), windows $ f i)
        | (i, k) <- zip myWorkspaces ([xK_1..xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- Bind mod-{w,e,r} to screen 1 0 2 because it's much more logical in Dvorak.
    [((m .|. myModKey, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 0, 2] -- was [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-- Confirm action with dmenu
confirm :: String -> X () -> X ()
confirm msg f = do
    result <- menuArgs "dmenu" ["-p", msg] ["no", "yes"]
    when (result == "yes") f

------------------------------------------------------------------------
---- Layouts:
-- 
-- -- You can specify and transform your layouts by modifying these values.
-- -- If you change layout bindings be sure to use 'mod-shift-space' after
-- -- restarting (with 'mod-q') to reset your layout state to the new
-- -- defaults, as xmonad preserves your old layout settings by default.
-- --
-- -- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- -- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- -- Instead use the 'ewmh' function from that module to modify your
-- -- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- -- startupHook ewmh notes.)
-- --
-- -- The available layouts.  Note that each layout is separated by |||,
-- -- which denotes layout choice.
-- --
myLayout = avoidStruts (
    tiled |||
    Mirror tiled |||
    Full |||
    tabbed shrinkText tabConfig) |||
    noBorders (fullscreenFull Full)
         where tiled = Tall 1 (3/100) (1/2)

-- Tab layout configuration
tabConfig = defaultTheme
    { activeBorderColor   = "grey"
    , activeTextColor     = "white"
    , activeColor         = "black"
    , inactiveBorderColor = "grey"
    , inactiveTextColor   = "grey"
    , inactiveColor       = "black"
    }

------------------------------------------------------------------------
---- Window rules:
-- 
-- -- Execute arbitrary actions and WindowSet manipulations when managing
-- -- a new window. You can use this to, for example, always float a
-- -- particular program, or have a client always appear on a particular
-- -- workspace.
-- --
-- -- To find the property name associated with a program, use
-- -- > xprop | grep WM_CLASS
-- -- and click on the client you're interested in.
-- --
-- -- To match on the WM_NAME, you can use 'title' in the same way that
-- -- 'className' and 'resource' are used below.
-- --
myManageHook = composeAll
    [ className =? "Gimp"          --> doFloat
    , className =? "Vncviewer"     --> doFloat
    , className =? "Firefox"       --> doShift "2:web"
    , className =? "Thunderbird"   --> doShift "3:mail"
    , className =? "Pidgin"        --> doShift "3:mail"
    , className =? "VirtualBox"    --> doShift "9:vm"
    , className =? "Xfce4-notifyd" --> doIgnore -- Prevent to steal the focus.
    ] <+> namedScratchpadManageHook myScratchpads

------------------------------------------------------------------------
---- Scratchpad:
--
-- Scratchpad will spawn an application, or bring it to the current workspace
-- if it already exists. Pressing the key with the application on the current
-- workspace will send it to a hidden workspace called NSP.
--
myScratchpads =
    [ NS "terminal" spawnTerminal findTerminal manageTerminal
    , NS "ipython"  spawnIpython  findIpython  manageIpython
    ]
    where
        -- Terminal
        nameTerminal   = "scratchpad-terminal"
        spawnTerminal  = myTerminal ++ " -name " ++ nameTerminal
        findTerminal   = resource =? nameTerminal
        manageTerminal = customFloating $ W.RationalRect l t w h
            where
                h = 0.1     -- Terminal height, 10%
                w = 1       -- Terminal width, 100%
                t = 1 - h   -- Distance from top edge, 90%
                l = 1 - w   -- Distance from left edge, 0%
        -- IPython
        nameIpython    = "scratchpad-ipython"
        spawnIpython   = unwords
            [ myTerminal
            , "-name " ++ nameIpython
            , "-e sh"
            , "-c \"" ++ cmd ++ "\""
            ]
            where
                cmd = "ipython -i -c='from __future__ import division'"
        findIpython    = resource =? nameIpython
        manageIpython  = customFloating $ W.RationalRect l t w h
            where
                h = 0.5     -- Height
                w = 0.4     -- Width
                t = 0.1     -- Distance from top edge
                l = 1 - w   -- Distance from left edge

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad $ withUrgencyHook NoUrgencyHook
           $ defaultConfig
        { manageHook   = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , logHook      = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle  = xmobarColor "green" "" . shorten 50
            , ppSort   = fmap (.scratchpadFilterOutWorkspace) getSortByIndex
            , ppUrgent = xmobarColor "red" "" . xmobarStrip
            }
        , modMask      = myModKey
        , terminal     = myTerminal
        , workspaces   = myWorkspaces
        , layoutHook   = smartBorders $ myLayout
        } `additionalKeys` myKeys
