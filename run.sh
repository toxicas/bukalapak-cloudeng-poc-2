#!/bin/bash

## Setup  extension group
declare -a type_document=("doc" "docx" "txt")
declare -a type_image=("jpg" "png")
declare -a type_program=("bin" "exe")
declare -a type_sql=("sql")

# Setup group array variable
declare -a document_files=()
declare -a image_files=()
declare -a program_files=()
declare -a sql_files=()

# Function for grouping file extension
group_file_by_extension() {
	if [ -z "$1" ];
	then
		echo "No file was processed"
	fi

	## Extract file extension
	filename="$1"
	extension="${filename##*.}"

	# Compare input with defined group array
	for item in "${type_document[@]}"; 
	do
		if [ "${item}" = "${extension}" ];
		then
			document_files+=("$1")
		fi
	done

	for item in "${type_image[@]}"; 
        do
                if [ "${item}" = "${extension}" ];
                then
                        image_files+=("$1")
                fi
        done

	for item in "${type_program[@]}"; 
        do
                if [ "${item}" = "${extension}" ];
                then
                        program_files+=("$1")
                fi
        done

	for item in "${type_sql[@]}"; 
        do
                if [ "${item}" = "${extension}" ];
                then
                        sql_files+=("$1")
                fi
        done
}

if  [ -z "$1" ];
then
	echo "[ERROR] Required arguments one to be define for directory to be scanned"
fi

directory="$1"

echo "Scanning directory \"$directory\" for any files"
echo "-----------------------------------------------"

list_files=(`ls -B "$directory"`)\

for i in "${list_files[@]}"
do
	group_file_by_extension "$i"
done

## Print specific group 
echo -e "\n"
echo "Document Files :"
echo -e "Count \t: ${#document_files[@]}"
echo -e "List \t: ${document_files[@]}" 
echo -e "-----------------------------\n"

echo "Image Files :"
echo -e "Count \t: ${#image_files[@]}"
echo -e "List \t: ${image_files[@]}"
echo -e "-----------------------------\n"

echo "Program Files :"
echo -e "Count \t: ${#program_files[@]}"
echo -e "List \t: ${program_files[@]}"
echo -e "-----------------------------\n"

echo "SQL Files :"
echo -e "Count \t: ${#sql_files[@]}"
echo -e "List \t: ${sql_files[@]}"
echo -e "-----------------------------\n"
