module Stagehand
  class Client
    # Methods for Accounts
    module Account
      # Public: Adds role to account
      #
      # id   - The account id
      #
      # Examples
      #
      #   add_role("", 4)
      #   # => "{\"id\":\"4e691653fc595d0001000002\",\"account_id\"
      #      :\"4ede1caf9a811123ca000001\"}"
      #
      # Returns a person JSON object
      def add_role()
        get_with_access_token("/people/find_by_email/#{email}").body
      end

      # Public: Finds accounts by role
      #
      # role   - Role to search by
      #
      # Examples
      #
      #   find_by_role("admin")
      #   # => "{\"id\":\"4e691653fc595d0001000002\",\"account_id\"
      #      :\"4ede1caf9a811123ca000001\"}"
      #
      # Returns accounts JSON object
      def find_by_role(role)
        get_with_access_token("/accounts/find_by_role/#{ERB::Util.url_encode(role)}")
      end
    end
  end
end
