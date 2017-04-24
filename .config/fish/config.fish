# prompt
function fish_prompt --description 'Write out the prompt'
  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd ''
  switch $PWD
    case $HOME
      set pwd '~'
    case '*'
      set pwd (basename $PWD)
  end
  # set -l pwd (basename $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')
  set -l prompt_symbol ''
  switch $USER
    case root toor
      set prompt_symbol '#'
    case '*'
      set prompt_symbol '$'
  end
  printf "[%s@%s %s]%s " $USER (prompt_hostname) $pwd $prompt_symbol
end

# peco
function fish_user_key_bindings
  bind \cr peco_select_history
end

# 自分の好きなエイリアス定義
alias chromium="chromium > /dev/null 2>&1"
alias mikutter="mikutter > /dev/null 2>&1"
alias libreoffice="libreoffice > /dev/null 2>&1"
function arduino 
  platformio $argv ; and echo "upload_port = /dev/ttyACM0" >> platformio.ini ; and echo "void setup(){\n  // put your setup code here, to run once:\n}\nvoid loop(){\n  // put your main code here, to run repeatedly:\n}" > src/main.ino
end
