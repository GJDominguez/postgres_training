#! /bin/bash

# PSQL Connection
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Set Argument
ARGUMENT=$1

CHECK_ARGUMENT(){
# Check if arguments exists
  if [[ -z $ARGUMENT ]]
  then
    echo "Please provide an element as an argument."
    exit 0
  fi
}

IS_ATOMIC_NUMBER(){
  # Verificamos si es numero
  if [[ ! $ARGUMENT =~ ^[0-9]$ ]]
  then
    return 1
  fi
  # Verificamos si esta en la tabla
  if [[ -z "$($PSQL "SELECT * FROM elements WHERE atomic_number = $ARGUMENT ")" ]]
  then
    return 1
  fi
  # Retornamos verdadero pasados las demas casuisticas
  return 0
}

IS_SYMBOL(){
  if [[ -z "$($PSQL "SELECT * FROM elements WHERE symbol = '$ARGUMENT' ")" ]]
  then
    return 1
  fi
  return 0
}

IS_NAME(){
  if [[ -z "$($PSQL "SELECT * FROM elements WHERE name = '$ARGUMENT' ")" ]]
  then
    return 1
  fi
  return 0
}

PRINT_MESSAGE(){
  # if no argumets
  if [[ -z $1 ]]
  then
    echo "I could not find that element in the database."
    exit 0 
  fi
  # get data from query
  RESULT="$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $1 ")"
  echo $RESULT | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
  do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  done
}


CHECK_ARGUMENT

if IS_ATOMIC_NUMBER; then
  PRINT_MESSAGE "atomic_number = $ARGUMENT"
elif IS_SYMBOL ; then
  PRINT_MESSAGE "symbol = '$ARGUMENT'"
elif IS_NAME ; then
  PRINT_MESSAGE "name = '$ARGUMENT'"
else
  PRINT_MESSAGE 
fi
