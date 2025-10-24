# cp <some_git_repo>/.git/hooks/*.sample .

for f in *.sample
    set -l command_name (echo "$f" | uvx repx '/\.sample$//')
    if [ -not -f "$command_name" ]
      cat shim.template | uvx repx "/pre-push/$command_name/" > "$command_name"
    end
end

# rm *.sample
