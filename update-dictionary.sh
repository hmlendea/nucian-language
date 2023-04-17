#!/bin/bash

DICTIONARY_FILE="docs/DICTIONARY.md"
PGD_XML_FILE="PGDictionary.xml"

# Parse the XML and extract the required information
DICTIONARY_CONTENT=$(\
    xmlstarlet sel -t -m "//lexicon/word" -v "concat('|',conWord,'|', /dictionary/partsOfSpeech/class[classId=current()/wordTypeId]/className,'|',localWord,'|',definition,'|')" -n "${PGD_XML_FILE}" | \
    sed 's/\r//g' | \
    sed -e 's/&lt;/</g' -e 's/&gt;/>/g' | \
    sed \
        -e 's/<[^>]*>//g' | \
    grep -v "^\s*$" | \
    sed \
        -e 's/[ ][ ]*/ /g' \
        -e 's/^\s*//g' \
        -e 's/\s*$//g' | \
    sed -E ':a;N;$!ba;s/(\|)\n([^|])/\1\2/g' | \
    sed -E ':a;N;$!ba;s/\n\s*\|\s*\n/\|\n/g')

# Write the output to a file
echo "| Word | Class | Translation | Definition |" > "${DICTIONARY_FILE}"
echo "|------|-------|-------------|------------|" >> "${DICTIONARY_FILE}"
echo "${DICTIONARY_CONTENT}" >> "${DICTIONARY_FILE}"