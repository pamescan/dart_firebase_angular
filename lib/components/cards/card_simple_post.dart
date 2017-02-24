import 'package:angular2/core.dart';
import 'package:pamescan/items/SimplePost.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:angular2/router.dart';

@Component(
  selector: 'card-simple-post',
  styleUrls: const ['card_simple_post.css'],
  templateUrl: 'card_simple_post.html',
  directives: const [materialDirectives,ROUTER_DIRECTIVES],
  providers: const [],
  )
class CardSimplePost {
  @Input() SimplePost post;
  @Input() bool disabledButtons;
  @Output()  EventEmitter<String> delete=new EventEmitter<String>();
  @Output()  EventEmitter<String> edit=new EventEmitter<String>();

  onClickDelete(){

    this.delete.emit(post.key);
  }

  onClickEdit(){
    this.edit.emit(post.key);

  }

}