#!/bin/bash

generate_password() {
    local length=$1
    local complexity=$2

    # Define character sets based on complexity
    case $complexity in
        low)
            charset="a-zA-Z0-9"
            ;;
        medium)
            charset="a-zA-Z0-9!@#%^&*()-=_+[]{}|;:'\",.<>/?"
            ;;
        high)
            charset="a-zA-Z0-9!@#%^&*()-=_+[]{}|;:'\",.<>/?~"
            ;;
        *)
            echo "Invalid complexity option"
            exit 1
            ;;
    esac

    # Generate password
    password=$(tr -cd "$charset" < /dev/urandom | head -c "$length")
    echo "$password"
}

# Use Zenity to create a GUI for input
lengths=$(zenity --entry --title "Password Generator" --text "Enter password lengths (comma-separated):" --entry-text "12,16,20")
IFS=',' read -ra length_array <<< "$lengths"

# Check if the user canceled the input
if [[ $? -ne 0 ]]; then
    echo "User canceled."
    exit 1
fi

# Use Zenity to create a GUI for selecting password complexity
complexity=$(zenity --list --title "Password Generator" --text "Select password complexity:" --radiolist --column "Select" --column "Complexity" TRUE "low" FALSE "medium" FALSE "high")

# Check if the user canceled the input
if [[ $? -ne 0 ]]; then
    echo "User canceled."
    exit 1
fi

# Generate and display passwords using xmessage
generated_passwords="Generated Passwords:"
for length in "${length_array[@]}"; do
    generated_password=$(generate_password "$length" "$complexity")
    generated_passwords+="\nLength: $length\nPassword: $generated_password\n"
done

# Use xmessage to display the generated passwords
echo -e "$generated_passwords" | xmessage -file -

