module HoneyPotEngine
  class Engine < ::Rails::Engine
    isolate_namespace HoneyPotEngine
    initializer "honey_pot_engine.auto_guard" do
      ActiveSupport.on_load(:action_controller) do
        require_relative "controller_guard"
        ActionController::Base.prepend(HoneyPotEngine::ControllerGuard)
      end
    end

    initializer "honey_pot_engine.inject_form_hook" do
      ActiveSupport.on_load(:action_view) do
        require_relative "form_injector"  # 相対パスでもOK
        ActionView::Base.prepend(HoneyPotEngine::FormInjector)
      end
    end
  end
end
