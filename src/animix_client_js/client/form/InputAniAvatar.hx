package animix_client_js.client.form;

import js.html.Element;
import js.html.URL;
import js.html.ImageElement;
import js.html.Event;
import js.html.InputElement;
import js.Browser;
import js.html.InputEvent;
import js.html.MouseEvent;

class InputAniAvatar extends AView {

	var _drag :Element;

    public function new() {
		_drag = null;
        super('div');
		_dom.classList.add('input-ani-avatar');
        var s = '
            <input type="file" data-input-avatar />
            <div class="bg-checkboard wrapper-img-preview" data-wrapper-preview style="display: none">
                <img class="img-fluid" src="" alt="" data-img-preview />
                <div data-marker-eye-0 style="top:10%;left:10%"></div>
                <div data-marker-eye-1 style="top:10%;left:70%"></div>
            </div>
			<style>
				.input-ani-avatar {
					position: relative;
				}

				[data-marker-eye-0],
				[data-marker-eye-1] {
					position: absolute; 

					border: 1px solid red;
					width: 10%;
					height: 10%;
					background-color: white;

					cursor: move;
				}

				.bg-checkboard{
					background-size: 40px 40px;
					background-image: radial-gradient(circle, #000000 1px, rgba(0, 0, 0, 0) 1px);
				}
			</style>
        ';
    
        _dom.innerHTML = s;

        var wrapper = _dom.querySelector('[data-wrapper-preview]');
        var marker_eye_0 = _dom.querySelector('[data-marker-eye-0]');
        var marker_eye_1 = _dom.querySelector('[data-marker-eye-1]');
        _dom
            .querySelector('[data-input-avatar]')
            .addEventListener('change',(event :InputEvent) -> {
                var target :InputElement = cast event.target;
                var file = target.files.item(0);
                if( file == null )  return; // TODO : support input reset

                var img :ImageElement = 
					cast Browser.document.querySelector('[data-img-preview]');
                img.src = URL.createObjectURL(file);

                img.dispatchEvent( new Event('inputfile-preview', cast {
                    target: img, input: target, bubbles: true,
                }) );

                wrapper.style.display = '';
            });
        
        marker_eye_0.addEventListener('mousedown', () -> {
			_drag = marker_eye_0;
        });
		marker_eye_1.addEventListener('mousedown', () -> {
			_drag = marker_eye_1;
        });
        marker_eye_0.addEventListener('mouseup', dragStop);
        marker_eye_1.addEventListener('mouseup', dragStop);


        Browser.document.addEventListener('mousemove', dragMove);
    }

	public function dragStart(event :MouseEvent) {
		if( _drag == null ) return; 
		var box = _dom.getBoundingClientRect();
        _drag.style.top = (event.clientY - box.top)+'px';
        _drag.style.left = (event.clientX - box.left)+'px';
    }

	public function dragStop(event :MouseEvent) {
		_drag = null;
    }

    public function dragMove(event :MouseEvent) {
		if( _drag == null ) return; 
		var box = _dom.getBoundingClientRect();
        _drag.style.top = (event.clientY - box.top)+'px';
        _drag.style.left = (event.clientX - box.left)+'px';
    }
    


}