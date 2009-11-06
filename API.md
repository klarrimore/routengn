# RouteNGN API
The following outlines the operations that external applications can perform
via the RouteNGN API.

## Types & Operations
### Dialcode
#### List
Returns dialcodes for a given locale
##### URL
http://routengn.net/dialcodes
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

#### Add
Add a dialcode
##### URL
http://routengn.net/dialcodes
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *locale_id* [Required] id of locale to add dialcodes to
+ *digits* [Required] digits the dialcode contains

##### Response
    {
      id:        Int,
      locale_id: Int,
      digits:    Int
    }

#### Update
Update a dialcode
##### URL
http://routengn.net/dialcodes
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *dialcode_id* [Required] id of dialcode to update
+ *digits* [Required] digits the dialcode contains

##### Response
    {
      id:        Int,
      locale_id: Int,
      digits:    Int
    }

#### Delete
Delete a dialcode
##### URL
http://routengn.net/dialcodes
##### Verb
DELETE
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *dialcode_id* [Required] id of dialcode to update

##### Response
    Boolean

### Locale
#### List
Returns locales for a given region
##### URL
http://routengn.net/locales
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

#### Add
Add a locale to a region
##### URL
http://routengn.net/locales
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Required] id of region to add locales to
+ *name* [Required] name of the locale

##### Response
    {
      id:        Int,
      region_id: Int,
      name:      String
    }

#### Update
Update the attributes of a locale
##### URL
http://routengn.net/locales
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *locale_id* [Required] id of locale to update
+ *name* [Optional] name of the locale

##### Response
    {
      id:        Int,
      region_id: Int,
      name:      String
    }

#### Delete
Delete a locale by its *id*
##### URL
http://routengn.net/locales
##### Verb
DELETE
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *locale_id* [Required] id of the locale to be deleted

##### Response
    Boolean

### Region
#### List/Show
Returns region for a given id or all regions
##### URL
http://routengn.net/regions
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Optional] id of region to show

##### Response
    {
      id:        Int,
      name:      String
    }

#### Add
Create a new region
##### URL
http://routengn.net/regions
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *name* [Required] name of the new region

##### Response
    {
      id:        Int,
      name:      String
    }

#### Update
Update the attributes of a region
##### URL
http://routengn.net/regions
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Required] id of region to update
+ *name* [Optional] new name for the region

##### Response
    {
      id:        Int,
      name:      String
    }

#### Delete
Delete a given region by *id*
##### URL
http://routengn.net/regions
##### Verb
DELETE
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *region_id* [Required] id of region to delete

##### Response
    Boolean

### Endpoints
#### List/Show
Returns endpoints for a given group
##### URL
http://routengn.net/endpoints
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *group_id* [Required] id of group to get endpoints from

##### Response
    {
      id:         Int,
      ip:         String,
      epgroup_id: Int
    }

#### Add
Add a new endpoint
##### URL
http://routengn.net/endpoints
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *ip* [Required] ip for the endpoint
+ *epgroup_id* [Required] id of group the endpoint belongs to

##### Response
    {
      endpoint: {
        ip:         String,
        epgroup_id: Int
      }
    }

#### Delete
Delete an endpoint
##### URL
http://routengn.net/endpoints
##### Verb
DELETE
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *id* [Required] id of the endpoint to update

##### Response
    Boolean

### Instance
#### List/Show
Returns instances for a given id or all instances
##### URL
http://routengn.net/instances
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *id* [Optional] id of instance

##### Response
    {
      id:         Int,
      type_id:    Int,
      name:       String,
      lastgen:    Time
    }

#### Add
Add a new instance
##### URL
http://routengn.net/instances
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *name* [Required] ids of groups
+ *type_id* [Required] id of the type for the instance

##### Response
    {
      instance: {
        id: Int,
        name: String,
        type_id: Int
      }
    }

#### Update/Generate
Generate LCR based on groups and instance
##### URL
http://routengn.net/instances
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *id* [Required] id of instance
+ *groups* [Required] ids of groups

##### Response
    Boolean

### Route
#### List/Show
Returns routes for a given instance
##### URL
http://routengn.net/routes
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *instance_id* [Required] id of instance

##### Response
    {
      id:           Int,
      locale_id:    Int,
      instance_id:  Int,
      type_id:      Int,
      epg_order:    String,
      epg_block:    String
    }

#### Update/Generate
Update LCR based on route change
##### URL
http://routengn.net/routes
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *instance_id* [Required] id of instance
+ *locale_id* [Required] id of locale
+ *routecase_id* [Required] id of route
+ *table_type* [Required] type of the table being updated
+ *route_type* [Required] type of the route being updated

##### Response
    Boolean

#### Search
Search for routes
##### URL
http://routengn.net/routes/search
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *search* [Required] search query for routes
+ *instance_id* [Required] id of instance
+ *table_type* [Required] type of the table being updated
+ *route_type* [Required] type of the route being updated

##### Response
    CSV

### Rate
#### List/Show
Returns rates based on group and/or locale
##### URL
http://routengn.net/rates
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *group_id* [Optional] id of group
+ *locale_id* [Optional] id of locale

##### Response
    {
      id:           Int,
      locale_id:    Int,
      epgroup_id:   Int,
      type_id:      Int,
      rate:         Double
    }

#### Add
Add a new rate
##### URL
http://routengn.net/rates
##### Verb
POST
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *rate* [Required] value for the rate
+ *type_id* [Required] id of type
+ *group_id* [Required] id of group
+ *locale_id* [Required] id of locale

##### Response
    {
      id:           Int,
      locale_id:    Int,
      epgroup_id:   Int,
      type_id:      Int,
      rate:         Double
    }

#### Update
Update attributes of a rate
##### URL
http://routengn.net/rates
##### Verb
PUT
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *id* [Required] id of the rate to update
+ *rate* [Optional] value for the rate
+ *type_id* [Optional] id of type
+ *group_id* [Optional] id of group
+ *locale_id* [Optional] id of locale

##### Response
    {
      id:           Int,
      locale_id:    Int,
      epgroup_id:   Int,
      type_id:      Int,
      rate:         Double
    }

#### Delete
Delete an existing rate
##### URL
http://routengn.net/rates
##### Verb
DELETE
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *id* [Required] id of the rate to delete

##### Response
    Boolean

### Type
#### List/Show
Returns type based on name
##### URL
http://routengn.net/types
##### Verb
GET
##### Formats
JSON
##### Authentication Required
Yes
##### Parameters
+ *name* [Required] name of type

##### Response
    {
      id:           Int,
      name:         String
    }

