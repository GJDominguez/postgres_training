#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

MAIN_TITLE(){

  if [[ -z $1 ]]
  then
    echo -e "\n~~~~~ MY SALON ~~~~~"
  else
    echo -e "\n$1"
  fi

  echo -e "\nWelcome to My Salon, how can I help you?\n"
  echo "$($PSQL "SELECT * FROM services")" | while IFS="|" read ID SERVICE
  do
    if [[ $ID =~ ^[0-9]$ ]]
    then
      echo -e "$ID) $SERVICE"
    fi
  done

}

PICK_SERVICE(){
  # Read Service
  read SERVICE_ID_SELECTED
  # Service ID doesnot exists
  if [[ -z "$($PSQL "SELECT * FROM services WHERE service_id = $SERVICE_ID_SELECTED")" ]]
  then
    MAIN_TITLE "Sorry, service not found"
    PICK_SERVICE
  fi
}

GET_CUSTOMER_PHONE_NUMBER(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
}


GET_CUSTOMER_NAME(){

  if [[ -z "$($PSQL "SELECT * FROM customers WHERE phone = '$CUSTOMER_PHONE'")" ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    $($PSQL "INSERT INTO customers(phone,name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  fi

}
GET_TIME_SERVICE(){
  
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME

}

CREATE_APPOINTMENT(){

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  AUX=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")

  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}

MAIN_TITLE
PICK_SERVICE
GET_CUSTOMER_PHONE_NUMBER
GET_CUSTOMER_NAME
GET_TIME_SERVICE
CREATE_APPOINTMENT
