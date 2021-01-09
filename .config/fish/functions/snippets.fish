# Usage:
#
# $ set -gx snippets_root /path/to/dir
# $ echo "echo 'snippet'" > $snippets_root/snippet
# $ snippets
# Snippets>
#   1/1
# > echo "snippet"
function snippets
    set -l buffer $argv
    test "$buffer" = '' && set buffer (commandline)

    # Snippets配置場所が未定義なら死ぬ
    test "$snippets_root" = '' && echo (set_color red)Error: \$snippets_root undefined. && return

    function __snippets_merge_snippets
      # ファイルをマージしていい感じに整形
      # ファイルをリストアップし、dotfilesを除外し、コメント行を削除し、ファイル名をタグにする
      find $snippets_root -type f | grep -E -v '\/\.[^\/]*$' | xargs grep -E '^\b*[^#]' | sed -e 's|:| |' \
          | awk -v pattern="$snippets_root/" ''' \
          {
            sub(pattern, "", $1)
            for (i = 2; i <= NF; i++) printf "%s ", $i
            print "#"$1
          }'''
    end

    function __snippets_fetch_snippets
        __snippets_merge_snippets | fzf +m --prompt='Snippets> ' --query "$argv" | cut -d '#' -f 1
    end

    set -l cmd (string trim (__snippets_fetch_snippets $buffer))
    set -l variables
    # 初出の変数のみ `$variables` に格納
    for v in (string collect (echo $cmd | grep -o '$[a-zA-Z0-9_]*'))
        contains $v $variables || set -a variables $v
    end

    test (count $variables) != 0 && echo (set_color yellow)$cmd(set_color normal)
    for v in $variables
        set -l default (eval echo $v)
        set -l variable_name (echo (string sub --start=2 $v))
        set -l tmp_variable_name "__snippets_$variable_name"

        # 環境変数を内部使用のものに置換
        set cmd (echo $cmd | sed -e "s/$v/\$$tmp_variable_name/g")

        # 内部変数を宣言
        set -l set_statement (echo "set $tmp_variable_name '$default'")
        eval "$set_statement"

        # 対話的に値を取得
        set -l input (read -c "$default" -p 'echo (set_color grey)"$v> "(set_color normal)')

        # 取得した値を内部変数に格納
        if test "$input" != ''
          set -l set_statement (echo "set $tmp_variable_name '$input'")
          eval "$set_statement"
        end
    end

    # eval する前にエスケープ
    # （変数を展開したいので $ はエスケープしない）
    set cmd (echo $cmd | sed -e "s|'|\\\\'|g" -e 's|"|\\\\"|g' -e 's|;|\\\\;|g' -e 's|&|\\\\&|g' -e 's,|,\\\\|,g')

    # 内部変数を展開
    set cmd (eval "echo $cmd")
    commandline "$cmd"
end
