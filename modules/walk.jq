# Apply f to composite entities recursively, and to atoms
# Source: <https://lucasbru.medium.com/comparison-of-json-files-9b8d2fc320ca>
# walk.filter
def walk(f):
  . as $in
  | if type == "object" then
      reduce keys[] as $key
        ( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
  elif type == "array" then map( walk(f) ) | f
  else f
  end;
walk(if type == "array" then sort else . end)
