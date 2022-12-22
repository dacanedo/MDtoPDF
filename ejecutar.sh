for archivo in $(find test/*.md)
do
	./conversor $archivo
done