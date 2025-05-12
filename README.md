# Tasks API

## Setup

- bundle install
- `rails db:setup`

### Testing

`rspec`


### Run the app

`rails s`


## API Docs (Swagger)

Run rails server and [view here](http://localhost:3000/api-docs)


## Usage

Below are examples of how to interact with the API using `curl`. Assumes the Rails server is running on `localhost:3000`.

### List all tasks

```bash
curl -X GET http://localhost:3000/api/tasks
```

### Create a new task

```bash
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{ "task": { "title": "Add Task", "description": null } }'
```

### Mark a task as completed

Replace `:id` with the task ID.

```bash
curl -X PATCH http://localhost:3000/api/tasks/:id/completed
```


## Assumptions

- ruby 3.3.8 already setup with rails gem installed
- no users / authentication


## Known limitations

- serialize on the model instead of a gem e.g Alba, active model serializers, etc.
- Sqlite instead of postgres/mysql - keeping it simple