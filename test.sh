
if (( $# != 2 )); then
    echo -e "Wrong number of arguments."
    exit 1
fi

test=$1
seed=$2

make

./gen/gen $seed > "${test}"

echo -e "Java time"
time make runJava < "${test}" > java_"${test}"
echo -e ""

echo -e "Java time -Xint"
time make runJavaXint < "${test}" > javaXint_"${test}"
echo -e ""

echo -e "C time"
time make runC < "${test}" > c_"${test}"
echo -e ""

echo -e "OCaml time"
time make runOcaml < "${test}" > ocaml_"${test}"
echo -e ""

diff java_"${test}" c_"${test}" > /dev/null
diff ocaml_"${test}" c_"${test}" > /dev/null
diff ocaml_"${test}" java_"${test}" > /dev/null

rm java_"${test}" javaXint_"${test}" c_"${test}" ocaml_"${test}" "${test}"
