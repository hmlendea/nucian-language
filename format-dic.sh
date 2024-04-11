#!/bin/bash
xmllint --format "PGDictionary.xml" > "PGDictionary.formatted.xml"
mv "PGDictionary.formatted.xml" "PGDictionary.xml"
