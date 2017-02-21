import 'package:angular2/core.dart';
import 'package:pamescan/items/SimplePost.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'card-simple-post-edit',
  styleUrls: const ['card_simple_post.css'],
  templateUrl: 'card_simple_post_edit.html',
  directives: const [materialDirectives],
  providers: const [],
  )
class CardSimplePostEdit {
  @Input() SimplePost post;
  @Input() bool isVisible;
  @Output() EventEmitter<SimplePost> onUpdate=new EventEmitter<SimplePost>();
  @Output() EventEmitter isVisibleChange=new EventEmitter();



  onClickUpdate() {
    this.onUpdate.emit(post);

  }

  onClickCancel() {
    this.isVisibleChange.emit(false);
  }

}