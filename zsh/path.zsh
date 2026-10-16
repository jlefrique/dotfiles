### Path

export PATH=${PATH}:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools:~/android-ndk
export PATH=${PATH}:~/tizen-sdk/tools
export PATH=${PATH}:~/git-annex
export PATH=${PATH}:~/.cargo/bin

# Lua (luarocks is optional)
command -v luarocks > /dev/null && eval "$(luarocks path --bin)"
