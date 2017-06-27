function web_server
    switch (count $argv)
        case 0
            ruby -run -e httpd . -p 3000
        case 1
            ruby -run -e httpd . -p $argv
    end
end
