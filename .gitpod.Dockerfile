FROM ludmann/workspace-full

RUN date > $HOME/data.txt
# fail if number.txt does not have a number >= 100
RUN test "$(cat $HOME/number.txt)" -lt "100"
