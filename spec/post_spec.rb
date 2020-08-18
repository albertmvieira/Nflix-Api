describe "post" do
  context "When new user" do
    #Pode usar o before ou let

    # Sempre será executado antes do it
    # before do
    #   new_user = build(:user).to_hash
    #   @result = ApiUser.save(new_user)
    # end

    # só será executado quando invocado dentro do it
    let(:result) { ApiUser.save(build(:user).to_hash) }

    it { expect(result.response.code).to eql "200" }
  end

  context "When duplicate email" do
    let(:result) { ApiUser.save(build(:registered_user).to_hash) }

    it { expect(result.response.code).to eql "409" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address." }
  end

  context "When wrong email" do
    let(:result) { ApiUser.save(build(:user_wrong_email).to_hash) }

    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email." }
  end

  context "When empty name" do
    let(:result) { ApiUser.save(build(:empty_name_user).to_hash) }

    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed" }
  end

  context "When empty email" do
    let(:result) { ApiUser.save(build(:empty_email_user).to_hash) }

    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed" }
  end

  context "When empty password" do
    let(:result) { ApiUser.save(build(:empty_password_user).to_hash) }

    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed" }
  end
end
