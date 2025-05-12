# Tasks API

## Setup

Install dependencies:
```bash
bundle install
```

Set up the database:
```bash
rails db:setup
```

## Testing

To run the test suite (RSpec):
```bash
rspec
```

## Run the app

Start the Rails server:
```bash
rails s
```
By default, the application will be available at `http://localhost:3000`.


## API Docs (Swagger)

To view the interactive API documentation (Swagger UI):

1.  Ensure the Rails server is running:
    ```bash
    rails s
    ```
2.  Open your web browser and navigate to:
    [http://localhost:3000/api-docs](http://localhost:3000/api-docs)


## Usage

Below are examples of how to interact with the API using `curl`. Assumes the Rails server is running on `localhost:3000`.

#### List all tasks

```bash
curl -X GET http://localhost:3000/api/tasks
```

#### Create a new task

```bash
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{ "task": { "title": "Add Task", "description": null } }'
```

#### Mark a task as completed

Replace `:id` with the task ID.

```bash
curl -X PATCH http://localhost:3000/api/tasks/:id/completed
```


## Assumptions

- ruby 3.3.8 already setup with rails gem installed
- no users / authentication
- no versioning of API


## Known limitations

- Serialize on the model instead of a gem e.g Alba, active model serializers, etc.
- Sqlite instead of postgres/mysql - keeping it simple