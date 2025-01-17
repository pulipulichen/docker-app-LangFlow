#!/bin/bash

curl -X POST \
    "http://localhost:7860/api/v1/run/c8b65f70-ff96-4fce-ad5f-3eb077b7bdb5?stream=false" \
    -H 'Content-Type: application/json'\
    -d '{"input_value": "請問name是誰？",
    "output_type": "chat",
    "input_type": "chat",
    "tweaks": {
  "ChatInput-uCXcE": {},
  "ParseData-qmqyf": {},
  "Prompt-86iGo": {},
  "SplitText-X5AAS": {},
  "ChatOutput-8YvER": {},
  "Directory-uSoYY": {},
  "GoogleGenerativeAIModel-QcKXH": {},
  "Chroma-NPNKf": {},
  "Chroma-Box7K": {},
  "HuggingFaceInferenceAPIEmbeddings-1gwi2": {},
  "CustomComponent-PpEVS": {},
  "CustomComponent-FaflT": {},
  "MergeDataComponent-RSRLE": {}
}}'
    