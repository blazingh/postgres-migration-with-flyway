#!/bin/bash

migration_dir="./migration"

# Check if migration directory exists and create it if not
if [ ! -d "$migration_dir" ]; then
  mkdir "$migration_dir"
  echo "Created migration directory: $migration_dir"
fi

# Find the latest migration file
latest_migration_file=$(ls -1v "$migration_dir"/*.sql 2>/dev/null | tail -n 1)

# Extract the version number from the latest migration file, or set it to 0 if no files exist
if [ -n "$latest_migration_file" ]; then
  latest_version=$(basename "$latest_migration_file" | awk -F'[_.]' '{print $2}')
else
  latest_version=0
fi

# Suggest a new version number based on the latest version
suggested_version=$(echo "$latest_version + 0.1" | bc)

# Prompt for version number
read -p "Enter version number (e.g., $suggested_version): " version_number

# Validate version number as number or float
if [[ ! "$version_number" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  echo "Invalid version number. Please provide a valid number or float."
  exit 1
fi

# Prompt for migration name
read -p "Enter migration name (e.g., create table): " migration_name

# Replace spaces with underscores in migration name
migration_name=${migration_name// /_}

# Generate the migration file name
migration_file="${migration_dir}/V${version_number}__${migration_name}.sql"

# Check if the file already exists
if [ -f "$migration_file" ]; then
  echo "Migration file already exists: $migration_file"
else
  # Create the migration file
  touch "$migration_file"
  echo "Migration file created: $migration_file"
fi
