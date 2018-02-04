module FlashHelper

  def flash_error_format(object)
    object.errors.full_messages.each do |message| 
      message
    end.to_s.remove(']','"','[')
  end
  
  # Obtengo representación HTML de los mensajes Flash
  def flash_messages
    capture do
      flash.each do |type, message|
        concat flash_message(type, message)
      end
    end
  end

  private

  # Convierte un mensaje flash a formato Snackbar.
  def flash_message(klass, message)
    new_klass = 'warning' if klass == 'warning'
    new_klass = 'success' if klass == 'success' || klass == 'notice'
    new_klass = 'danger' if klass == 'error' || klass == 'danger' || klass == 'alert'

    case new_klass
    when 'warning'
      bg_color = 'bg-yellow'
    when 'success'
      bg_color = 'bg-green'
    when 'danger'
      bg_color = 'bg-red'
      
    end

    data = {
      toggle: :snackbar,
      style: "#{new_klass} callout callout-#{new_klass} #{bg_color}",
      content: message,
      timeout: 10000
    }
        
    # Descarta mensaje para que no ocurran 'ecos'
    flash.discard(klass)

    content_tag :span, nil, class: "snackbar-message #{new_klass}", data: data
  end

end