module Stagehand
  class Account
    def initialize
      @account ||= Stagehand.current_profile
    end

    def roles
      if @account
        roles = []
        @account['roles'].each do |r|
          roles << r['name']
        end
        roles.empty? ? ["registered_user"] : roles
      else
        ["guest"]
      end
    end

    def is?(role)
      roles.include?(role.to_s)
    end

    def method_missing(method, *params)
      method = method.to_s
      if @account && @account.keys.include?(method)
        return @account[method]
      else
        return ""
      end
    end
  end
end
