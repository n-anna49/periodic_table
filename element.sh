PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")

    if [[ -z $NAME ]]
    then
      echo "I could not find that element in the database."
    else
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$1")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $1 is $(echo $NAME | sed 's/ |/"/') ($(echo $SYMBOL | sed 's/ |/"/')). It's a $(echo $TYPE | sed 's/ |/"/'), with a mass of $(echo $ATOMIC_MASS | sed 's/ |/"/') amu. $(echo $NAME | sed 's/ |/"/') has a melting point of $(echo $MELTING_POINT | sed 's/ |/"/') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ |/"/') celsius."
    fi
  elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")

    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed 's/ |/"/') is $(echo $NAME | sed 's/ |/"/') ($(echo $1 | sed 's/ |/"/')). It's a $(echo $TYPE | sed 's/ |/"/'), with a mass of $(echo $ATOMIC_MASS | sed 's/ |/"/') amu. $(echo $NAME | sed 's/ |/"/') has a melting point of $(echo $MELTING_POINT | sed 's/ |/"/') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ |/"/') celsius."
    fi
  elif [[ $1 =~ ^[A-Za-z]{3,100}$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")

    if [[ -z $SYMBOL ]]
    then
      echo "I could not find that element in the database."
    else
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed 's/ |/"/') is $(echo $1 | sed 's/ |/"/') ($(echo $SYMBOL | sed 's/ |/"/')). It's a $(echo $TYPE | sed 's/ |/"/'), with a mass of $(echo $ATOMIC_MASS | sed 's/ |/"/') amu. $(echo $1 | sed 's/ |/"/') has a melting point of $(echo $MELTING_POINT | sed 's/ |/"/') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ |/"/') celsius."
    fi
  fi
else
echo "Please provide an element as an argument."
fi