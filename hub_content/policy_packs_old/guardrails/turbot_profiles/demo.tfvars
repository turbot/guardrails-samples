# Exisiting directory id which profiles are being created in
# e.g. "123456789012345"
directory_id = "123456789012345"  # replace with the Directory Id you are using


# Update this profile list to add in profiles into the directory
# For a turbot.com directory, the profileId would be the turbot.com username
# Name is the Full Name, the profile logic just assumes a First and Last Name separated by a space
# email is the email of the turbot.com profileId
# e.g. "bob" = { name = "Bob Tordella", email = "bob.tordella@turbot.com" },
user_profile = {
  "profileId1" = { name = "First Last", email = "email@email.com" },
  "profileId2" = { name = "First Last", email = "email@email.com" },
  "profileId3" = { name = "First Last", email = "email@email.com" }
}