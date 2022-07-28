import 'package:animals_adoption_flutter/screens/messages/widgets/custom_message_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

import '../../widgets/custom_bottom_navigator_bar.dart';

const int messagesCount = 10;

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  late int messageDirection;

  @override
  void initState() {

    messageDirection = 1;

    // Initialize controllers
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller, 
        curve: Curves.ease
      ))..addListener(() { 
        setState(() {
        });
      });

    // Start animation
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() { });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double messagesWidthPosition = _responsive.wp(5) * _animation.value;

    return CustomScaffold(
      title: 'Messages',
      withBackButton: true,
      bottomNavigator: CustomBottomNavigatorBar(),
      body: [
        Text(
          'Total messages: $messagesCount',
          style: TextStyles.lightGreyw600(_responsive.dp(1.25)),
        ),
        Opacity(
          opacity: 1 - _animation.value,
          child: Padding(
            padding: EdgeInsets.only(top: _responsive.hp(2.5)),
            child: SizedBox(
              height: (_responsive.hp(10) + _responsive.hp(1.5)) * messagesCount,
              child: ListView.separated(
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: messagesCount,
                separatorBuilder: (_, x) => SizedBox(height: _responsive.hp(1.5)),
                itemBuilder: (_, x) {
                  final double messagePositionWithCustomDirection = messagesWidthPosition * messageDirection;
                  messageDirection *= -1;
                  return Transform(
                    transform: Matrix4.identity()..translate(
                      messagePositionWithCustomDirection
                    ),
                    child: const CustomMessagesContainer());
                }
              ),
            ),
          ),
        )
      ],
    );
  }
}