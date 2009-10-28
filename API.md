# RouteNGN API
The following outlines the operations that external applications can perform
via the RouteNGN API.

## Types & Operations
### Dialcode
#### List
Returns dialcodes for a given locale
##### URL
http://routengn.net/dialcodes/*locale_id*
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *locale_id* [Required] id of locale to get dialcodes from

##### Response
    {
      id:        Int,
      locale_id: Int,
      digits:    Int
    }

### Locale
#### List
Returns locales for a given region
##### URL
http://routengn.net/locales/*region_id*
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Required] id of region to get locales from

##### Response
    {
      id:        Int,
      region_id: Int,
      name:      String
    }

### Region
#### List/Show
Returns region for a given id or all regions
##### URL
http://routengn.net/regions/*region_id*
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Optional] id of region to get locales from

##### Response
    {
      id:        Int,
      name:      String
    }

