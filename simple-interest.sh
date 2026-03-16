#!/bin/bash

# Simple Interest Calculator

echo "Simple Interest Calculator"

# Taking user input

echo "Enter Principal Amount:"
read principal

echo "Enter Rate of Interest:"
read rate

echo "Enter Time Period (in years):"
read time

# Calculating Simple Interest

simple_interest=$(echo "($principal * $rate * $time) / 100" | bc)

# Display result

echo "Simple Interest is: $simple_interest"
