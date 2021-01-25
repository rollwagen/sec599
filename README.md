# sec599 lab

[Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/) based purple team lab for a local (VMWare Fusion) based environment.



      192.168.10.x
    +-----------------------------------------------------+
         .5 |    .15 |    .16 |          |      .17 |
            |        |        |          |          |
            |        |        |          |          |
        +------+ +-------+ +-------+ +--------+ +--------+ 
        |      | |       | |       | |        | |  JUMP  |
        |  DC  | | Win10 | | Win10 | | UBUNTU | |  HOST  |
        |      | |   01  | |   02  | |  ELK*  | |  (RDP) |
        +------+ +-------+ +-------+ +--------+ +--------+
 
    (*) _in progress_

* `DC` - 192.168.1.5 - _Credentials:_ Administrator/Admin123, _Domain:_ `seclabs.lab`, _safemodepwd:_ Seclabs123
