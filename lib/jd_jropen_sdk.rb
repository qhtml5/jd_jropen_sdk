require "openssl"
require "base64"
require "json"
require "active_support/all"

Dir["#{File.dirname(__FILE__)}/jd_jropen_sdk/*.rb"].each do |path|
  require path
end

module JdJropenSdk
  module SdkResponseCode
    SUCCESS                = %w(00000 成功)
    FAILURE                = %w(55555 失败)
    UNKNOWN                = %w(99999 未知)
    SDK_UNKNOWN            = %w(01000 SDK未知异常)
    SDK_SIGN_FAIL          = %w(01001 SDK签名失败)
    SDK_ENCRYPT_FAIL       = %w(01002 SDK加密失败)
    SDK_VERIFY_SIGN_FAIL   = %w(01003 SDK验签失败)
    SDK_DECRYPT_FAIL       = %w(01004 SDK解密失败)
    SDK_UNSUPPORT_MSG_TYPE = %w(01005 SDK不支持的消息类型)
    MAPI_VERIFY_SIGN_FAIL  = %w(02003 MAPI验签失败)
    MAPI_PARTNER_NOT_EXIT  = %w(02005 开发者不存在)
    SFTP_UNKNOWN_ERROR     = %w(03001 SFTP未知异常)
  end

  class SdkException < StandardError
    attr_reader :code

    def initialize(sdk_response_code, message = nil)
      if SdkResponseCode.const_defined? sdk_response_code.upcase
        @code, msg = SdkResponseCode.const_get sdk_response_code.upcase
        super(message || msg)
      else
        super(message || sdk_response_code)
      end
    end
  end
end
