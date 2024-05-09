{ config, username, emailAddress, ... }:
{
  accounts.email.accounts = {
    ${username} = {
      primary = true;
      neomutt = {
        enable = true;
      };
    };
  };
}
