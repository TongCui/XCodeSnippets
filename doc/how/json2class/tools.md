# Json to Class

[JSONExporter](https://github.com/Ahmed-Ali/JSONExport)

# Ruby Tools

## JSON to Schema

[json-schema-generator](https://github.com/maxlinc/json-schema-generator)

```
json-schema-generator my_sample.json --schema-version draft3
```

```
Ruby:
file = 'my_sample.json'

JSON::SchemaGenerator.generate file, File.read(file), {:schema_version => 'draft3'}
```


## JSON viewer

[jq](https://stedolan.github.io/jq/tutorial/)

```
curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.[0]'
```


## Converter

[nidyx](https://github.com/cknadler/nidyx)

```
nidyx example.json.schema -x Example
```
