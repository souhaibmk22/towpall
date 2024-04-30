import 'package:flutter/material.dart';


class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String firstName = 'Aness';
  String lastName = 'Mellel';
  String birthday = 'Birthday';
  String email = 'aa.mellel@esi-sba.dz';
  String gender = 'Man';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 1.58, 
           
          ),
        ),
        centerTitle: true, 
        leading: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/pic.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  'Information',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    letterSpacing: 0,
                    color: Colors.grey,
                  ),
                ),
              ),
              UserInfoCard(
                label: 'First Name',
                initialValue: firstName,
                onChanged: (value) {
                  setState(() {
                    firstName = value;
                  });
                },
                setStateCallback: () {
                  setState(() {});
                },
              ),
              UserInfoCard(
                label: 'Last Name',
                initialValue: lastName,
                onChanged: (value) {
                  setState(() {
                    lastName = value;
                  });
                },
                setStateCallback: () {
                  setState(() {});
                },
              ),
              UserInfoCard(
                label: 'Birthday',
                initialValue: birthday,
                onChanged: (value) {
                  setState(() {
                    birthday = value;
                  });
                },
                setStateCallback: () {
                  setState(() {});
                },
              ),
              UserInfoCard(
                label: 'Email',
                initialValue: email,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                setStateCallback: () {
                  setState(() {});
                },
              ),
              UserInfoCard(
                label: 'Gender',
                initialValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                setStateCallback: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoCard extends StatefulWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback setStateCallback;

  const UserInfoCard({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    required this.setStateCallback,
  }) : super(key: key);

  @override
  _UserInfoCardState createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    if (widget.label == 'Gender') {
      return DropdownButtonFormField<String>(
        value: widget.initialValue,
        items: ['Man', 'Woman'].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.onChanged(value!);
            widget.setStateCallback();
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF89898999)),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF89898999)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF89898999)),
        ),
        child: TextField(
          focusNode: _focusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          controller: _controller,
          style: const TextStyle(
            color: Color(0xFF89898999),
          ),
          onChanged: (newValue) {
            widget.onChanged(newValue);
            widget.setStateCallback();
          },
          onTap: () {
            if (_controller.text == widget.initialValue) {
              _controller.clear();
            }
          },
          onEditingComplete: () {
            if (_controller.text.isEmpty) {
              _controller.text = widget.initialValue;
            }
            _focusNode.unfocus();
          },
        ),
      );
    }
  }
}


