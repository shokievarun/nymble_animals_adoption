import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';

import 'widgets/widget.dart';

const int messagesCount = 10;

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with SingleTickerProviderStateMixin{

  BasicCustomAnimation? _animator;
  int? messageDirection;

  @override
  void initState() {

    messageDirection = 1;

    _animator = BasicCustomAnimation(
      listener: _animationListener, 
      tickerProvider: this,
      begin: 1,
      end: 0,
      durationInMillisec: 500
    );
    super.initState();
  }

  void _animationListener() => setState(() {});

  @override
  void dispose() {
    _animator!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    final double messagesWidthPosition = _responsive.wp(5) * _animator!.getValue;

    return BaseScaffold(
      title: 'Messages',
      withBackButton: true,
      withBottomNavigator: true,
      body: [
        Text('Total messages: $messagesCount', style: TextStyles.lightGreyw600(_responsive.dp(1.25))),
        Opacity(
          opacity: 1 - _animator!.getValue,
          child: Padding(
            padding: EdgeInsets.only(top: _responsive.hp(2.5)),
            child: SizedBox(
              height: (_responsive.hp(10) + _responsive.hp(3)) * messagesCount,
              child: ListView.separated(
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: messagesCount,
                separatorBuilder: (_, x) => SizedBox(height: _responsive.heightSeparator),
                itemBuilder: (_, x) {
                  final double messagePositionWithCustomDirection = messagesWidthPosition * messageDirection!;
                  messageDirection = messageDirection! * -1;
                  return Transform(
                    transform: Matrix4.identity()..translate(
                      messagePositionWithCustomDirection
                    ),
                    child: const MessagesContainer());
                }
              ),
            ),
          ),
        )
      ],
    );
  }
}