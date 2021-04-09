#Datos Generales
export VER="1.9.4"
export VM_IP=192.168.2.1
export ATOL_IP=192.168.2.76
export DATA_DIR=data-dir
export CONFIG_DIR=config-dir
export ENCRYPT="qKWxUbmRyJnIPbRK2bmhKqP/1CQQ0whXncHhhFHX8E0=" #./consul keygen
export CLUSTER_JOIN="\"$VM_IP\", \"$ATOL_IP\""

#Herramientas
#apt install unzip
wget https://releases.hashicorp.com/consul/${VER}/consul_${VER}_linux_amd64.zip
unzip consul_${VER}_linux_amd64.zip
chmod +x consul
./consul version

#Nodo de VM
mkdir $DATA_DIR $CONFIG_DIR
export CURRENT_IP=$VM_IP
envsubst < "config.json.bk" > $CONFIG_DIR/config.json
./consul agent -node=vm -server -ui -advertise=$VM_IP -bind=$VM_IP -data-dir=$DATA_DIR -config-dir=$CONFIG_DIR

#Nodo de Atol
mkdir $DATA_DIR $CONFIG_DIR
export CURRENT_IP=$ATOL_IP
envsubst < "config.json.bk" > $CONFIG_DIR/config.json
./consul agent -node=atol -config-dir=$CONFIG_DIR


#Verificar Nodos
./consul members
