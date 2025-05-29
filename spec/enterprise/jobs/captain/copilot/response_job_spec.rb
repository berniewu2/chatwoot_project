require 'rails_helper'

RSpec.describe AiAgent::Copilot::ResponseJob, type: :job do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:topic) { create(:ai_agent_topic, account: account) }
  let(:copilot_thread) { create(:ai_agent_copilot_thread, account: account, user: user, topic: topic) }
  let(:conversation_id) { 123 }
  let(:message) { { 'content' => 'Test message' } }

  describe '#perform' do
    let(:chat_service) { instance_double(AiAgent::Copilot::ChatService) }

    before do
      allow(AiAgent::Copilot::ChatService).to receive(:new).with(
        topic,
        user_id: user.id,
        copilot_thread_id: copilot_thread.id,
        conversation_id: conversation_id
      ).and_return(chat_service)
      allow(chat_service).to receive(:generate_response).with(message)
    end

    it 'initializes ChatService with correct parameters and calls generate_response' do
      expect(AiAgent::Copilot::ChatService).to receive(:new).with(
        topic,
        user_id: user.id,
        copilot_thread_id: copilot_thread.id,
        conversation_id: conversation_id
      )
      expect(chat_service).to receive(:generate_response).with(message)
      described_class.perform_now(
        topic: topic,
        conversation_id: conversation_id,
        user_id: user.id,
        copilot_thread_id: copilot_thread.id,
        message: message
      )
    end
  end
end
