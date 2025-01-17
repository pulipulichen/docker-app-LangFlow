#!/bin/bash

curl -X POST \
    "http://localhost:7860/api/v1/run/ac0121ac-ada7-47d1-8aab-7253349b8d4e?stream=false" \
    -H 'Content-Type: application/json'\
    -d '{"input_value": "message",
    "output_type": "text",
    "input_type": "text",
    "tweaks": {
  "SplitText-WK7WO": {},
  "Directory-lzoUo": {},
  "Chroma-I8xFt": {},
  "HuggingFaceInferenceAPIEmbeddings-Lo5Pl": {},
  "MergeDataComponent-H17RJ": {}
}}'
    