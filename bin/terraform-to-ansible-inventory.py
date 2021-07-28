from collections.abc import Iterable
import os
import sys
import json

try:
  j = blob = json.load(sys.stdin)

  new = {}
  for k, v in blob.items():
    new[k] = v["value"]
  
  new = {"all": {"vars": new}}
  json.dump(new, fp=sys.stdout, indent=2)
except json.decoder.JSONDecodeError:
  print("Unable to parse content from Terraform", file=sys.stderr)
